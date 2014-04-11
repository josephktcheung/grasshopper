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

User.create(first_name: 'Grass', last_name: 'Hopper', email: 'gh@ga.co', password: '123', password_confirmation: '123', role: 'master')
User.create(first_name: 'App', last_name: 'rentice', email: 'ap@ga.co', password: '123', password_confirmation: '123', role: 'apprentice')
User.create(first_name: 'Master', last_name: 'Yoda', email: 'my@ga.co', password: '123', password_confirmation: '123', role: 'master')
Apprenticeship.create(master: User.find_by(id: 1), apprentice: User.find_by(id: 2), end_date: (-1.month.from_now))
Rating.create(rater: User.find_by(id: 1), ratee: User.find_by(id: 2), apprenticeship: Apprenticeship.find_by(id: 1), rating: 5)
skills = ['Ruby on Rails', 'Javascript', 'Jedi', 'Pascal']

skills.each { |skill| Skill.create(skill_name: skill) }

Skill.create(skill_name: 'Javascript')
Proficiency.create!(user: User.find(1), skill: Skill.find(1), proficiency_status: 'has')
Proficiency.create!(user: User.find(1), skill: Skill.find(2), proficiency_status: 'has')
Proficiency.create!(user: User.find(2), skill: Skill.find(1), proficiency_status: 'desired')
Conversation.create!(created_by: User.find(1), created_for: User.find(2))
Conversation.create!(created_by: User.find(1), created_for: User.find(3))
Conversation.create!(created_by: User.find(3), created_for: User.find(2))