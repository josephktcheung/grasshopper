# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
Apprenticeship.destroy_all
Rating.destroy_all
Skill.destroy_all
Proficiency.destroy_all
Conversation.destroy_all

u1 = User.create(first_name: 'Grass', last_name: 'Hopper', email: 'gh@ga.co', password: '123', password_confirmation: '123', role: 'master', about_me: 'Information about me will go here.')
u2 = User.create(first_name: 'App', last_name: 'rentice', email: 'ap@ga.co', password: '123', password_confirmation: '123', role: 'apprentice')
u3 = User.create(first_name: 'Master', last_name: 'Yoda', email: 'my@ga.co', password: '123', password_confirmation: '123', role: 'master')
a1 = Apprenticeship.create(master: u1, apprentice: u2, end_date: (1.month.from_now))
a2 = Apprenticeship.create(master: u3, apprentice: u2, end_date: (2.month.from_now))
Rating.create(rater: u1, ratee: u2, apprenticeship: a2, rating: 5)
Rating.create(rater: u2, ratee: u1, apprenticeship: a1, rating: 3)
skills = ['Ruby on Rails', 'Javascript', 'Jedi', 'Pascal']

skills.each { |skill| Skill.create(skill_name: skill) }

skills = Skill.last(3)

Skill.create(skill_name: 'Javascript')
Proficiency.create!(user: u1, skill: skills[1], proficiency_status: 'has')
Proficiency.create!(user: u1, skill: skills[2], proficiency_status: 'has')
Proficiency.create!(user: u2, skill: skills[1], proficiency_status: 'desired')

c1 = Conversation.create!(created_by: u1, created_for: u2)
Conversation.create!(created_by: u1, created_for: u3)
Conversation.create!(created_by: u3, created_for: u2)

Message.create!(conversation: c1, recipient: u1, sender: u2, content: 'Hello, I hope to work with you!')
Message.create!(conversation: c1, recipient: u2, sender: u1, content: 'Sure, let me know when you want to meet up!')


