module Games
  class Search
    include Virtus.model

    # input
    attribute :params, Hash
    attribute :user_signed_in, Boolean
    attribute :per_page, Integer
    attribute :user_is_admin, Boolean
    attribute :user_is_dev, Boolean
    attribute :current_user, User

    # output
    attribute :games

    def call
      @games = search(game_subset).order(desired_order)
      @games = @games.page(params[:page]).per(per_page)
    end

    private

    def game_subset
      Game.user_data_subset(user_is_admin, user_is_dev, current_user&.id)
    end

    def desired_order
      if user_signed_in
        "aasm_state='Rejected',aasm_state='Game not uploaded,
        it is not compatible with the system',aasm_state='Released to arcade',
        aasm_state='Not released', aasm_state= 'Game under review'"
      else
        "aasm_state='Not released',aasm_state='Released to arcade'"
      end
    end

    def search(subset)
      if params[:search_user]
        subset.search_by('user', params[:search_user])
      elsif params[:tag]
        subset.search_by('tags', params.require(:tag)[:tag_ids])
      elsif params[:search_main]
        subset.search_by('main', params[:search_main])
      else
        subset.order(desired_order)
      end
    end
  end
end
