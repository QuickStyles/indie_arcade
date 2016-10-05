class GamesController < ApplicationController
  before_action :find_game, only: [:show, :update, :edit]
  before_action :authenticate_user!, except: [:index, :show]

  GAMES_PER_PAGE = 6

  def index
    @tags = Tag.all
    service = Games::Search.new(params: params,
                                user_signed_in: user_signed_in?,
                                per_page: GAMES_PER_PAGE,
                                user_is_admin: user_is_admin?,
                                user_is_dev: user_is_dev?,
                                current_user: current_user)
    service.call
    @games = service.games
  end

  def show
  end

  def update
    game = Game.find params[:id]
    if cannot? :manage, game
      redirect_to root_path
    elsif game.update(game_params)
      redirect_to @game, notice: 'Game status was successfully updated.'
    else
      render :edit
    end
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    @game.user = current_user

    if @game.save
      redirect_to games_path, notice: 'Game was successfully uploaded.'
    else
      render :new
    end
  end

  def edit
    game = Game.find params[:id]
    redirect_to root_path if cannot? :manage, game
  end

  def destroy
    game = Game.find params[:id]
    if cannot? :manage, game
      redirect_to root_path
    else
      game.destroy
      redirect_to games_path
    end
  end

  private

  def find_game
    @game = Game.find params[:id]
  end

  def game_params
    params.require(:game).permit(:title, :cpu, :gpu, :ram, :size,
                                 :approval_date, :status_id, :stats,
                                 :description, :picture, :attachment,
                                 :link, tag_ids: [])
  end

  # Used to fulfill client requests for 5 new games
  def fill_machine_order(games)
    games.limit(5).order('RANDOM()')
  end
end
