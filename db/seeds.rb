# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(first_name: 'Grass', last_name: 'Hopper', email: 'gh@ga.co', password: '123', password_confirmation: '123', role: 'master')
User.create(first_name: 'App', last_name: 'rentice', email: 'ap@ga.co', password: '123', password_confirmation: '123', role: 'apprentice')
Apprenticeship.create(master: User.find_by(id: 1), apprentice: User.find_by(id: 2), end_date: (-1.month.from_now))
Rating.create(rater: User.find_by(id: 1), ratee: User.find_by(id: 2), apprenticeship: Apprenticeship.find_by(id: 1), rating: 5)