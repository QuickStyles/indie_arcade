USERS_TO_CREATE = 20
USERS_TO_CREATE.times do

	User.create company:					Faker::Company.name,
							email:						Faker::Internet.email,
							password:	        Faker::Internet.password,
							employees:				rand(8),
							website:					Faker::Internet.url

end
# works

User.create company:					"Admin Man",
						email:						"admin@admin.com",
						password:	        "123456",
						employees:				rand(8),
						website:					Faker::Internet.url,
						admin:						true

User.create company:					"Dev Man",
						email:						"dev@dev.com",
						password:	        "123456",
						employees:				rand(8),
						website:					Faker::Internet.url,
						admin:						false

business = ["Running", "Closed", "Updating"]
5.times do
    Location.create name:           Faker::Company.name,
                  	address:        Faker::Address.street_address,
                    city:           Faker::Address.city,
                    postal_code:    Faker::Address.zip_code,
                    run_status:     business.sample
end

20.times do
    Machine.create location_id:     1+rand(5)
end

["Adventure", "Action", "Strategy", "Multi-player", "Co-op", "Single-player", "Sport", "Racing"].each do |t|
    Tag.create name: t
end

100.times do
    Game.create({title: Faker::Hipster.word,
                  description: Faker::Hipster.paragraph,
                        user_id: 1+rand(22),
                        cpu: rand(100)+1,
                        gpu: rand(50)+1,
                        ram: 4+rand(17),
                        size: 1+ rand(4),
                        aasm_state: ["under_review", "rejected", "unreleased", "released", "incompatible"].sample })
end

50.times do
    Game.create({title: Faker::Lorem.words(2).join(" "),
                  description: Faker::Hipster.paragraph,
                        user_id: 1+rand(22),
                        cpu: rand(100)+1,
                        gpu: rand(50)+1,
                        ram: 4+rand(17),
                        size: 1+ rand(4),
                        aasm_state: ["under_review", "rejected", "unreleased", "released", "incompatible"].sample })
end

50.times do
    Game.create({title: Faker::App.name,
                  description: Faker::Hipster.paragraph,
                        user_id: 1+rand(22),
                        cpu: rand(100)+1,
                        gpu: rand(50)+1,
                        ram: 4+rand(17),
                        size: 1+ rand(4),
                        aasm_state: ["under_review", "rejected", "unreleased", "released", "incompatible"].sample })
end

50.times do
    Game.create({title: Faker::Book.title,
                  description: Faker::Hipster.paragraph,
                        user_id: 1+rand(22),
                        cpu: rand(100)+1,
                        gpu: rand(50)+1,
                        ram: 4+rand(17),
                        size: 1+ rand(4),
                        aasm_state: ["under_review", "rejected", "unreleased", "released", "incompatible"].sample })
end

TAGGINGS_TO_CREATE = 400
TAGGINGS_TO_CREATE.times do

   Tagging.create(game_id: rand(200)+1,
                  tag_id: 1+rand(8))
end

LOADS_TO_CREATE = 1000
LOADS_TO_CREATE.times do
    Load.create machine_id: 1+rand(20),
                game_id:    1+rand(200)
end

REVIEW_TO_CREATE = 5000
REVIEW_TO_CREATE.times do
	l = 1+ rand(1000)
	r = Review.create	load_id:			l,
										fun:					1+rand(5),
										difficulty:		1+rand(5),
										playability:	1+rand(5),
										game_id:    	Load.find(l).game.id
end
