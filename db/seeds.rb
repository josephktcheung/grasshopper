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

def seed_image(file_name)
  File.open(File.join(Rails.root, "/app/assets/images/seed/#{file_name}.jpg"))
end

about_cm = 'Master of everything, including web development.'
about_gh = 'Information about me will go here.'
about_ms = 'Information about me will go here.'
about_my = %{
  The Grand Master of the Jedi Council, I have trained Jedi for over 800 years.
  My small size causes many to underestimate me.
  I prefer meditation and reflection, spending much time pondering the mysteries of the Force.
  I have witnessed the decay of the Galactic Republic,
  and saw the Jedi Order transform from peacekeepers to battlefield commanders in the Clone Wars.
  When I must, I wield my lightsaber and becomes a whirling warrior of great speed and agility.
  A stern instructor, I nonetheless have a mischievous sense of humor.
  With the rise of the Galactic Empire, I fled into exile and awaited
  the arrival of a new Jedi student to rekindle a new hope in the galaxy.
  }.squish
about_ls = %{
  Raised as a farmboy on the backwater desert world of Tatooine,
  I had no idea that I was the secret son of Anakin Skywalker.
  After my stepparents were murdered by the Empire,
  I destroyed the Death Star and became the Rebellion's greatest hero.
  But my true destiny lay with the Jedi Order.
  I learned the ways of the Force from Obi-Wan Kenobi and Yoda,
  and discovered the terrible secret of my parentage.
  I insisted there was still good in Darth Vader, and my love for father reawakened Anakin's spirit,
  inspiring my dad to sacrifice himself to destroy Darth Sidious. lol.
  }.squish
about_dm = %{
  I began life as one of the Nightbrothers on Dathomir.
  Darth Sidious brutally trained me to be a weapon of the Sith as well as a scheming mastermind.
  A relentless and acrobatic warrior with an extremely dangerous double-ended lightsaber,
  I longed for revenge against the Jedi, to destroy the Order and restore power to the Sith.
  Defeated at the Battle of Naboo,
  I disappeared from the galaxy for over a decade before reemerging as a new threat during the Clone Wars.
  }.squish
about_ds = %{
  I was the last chancellor of the Old Republic,
  and the mastermind behind the biggest power-grab in galactic history.
  Practicing forbidden Sith techniques under my alternate identity of Darth Sidious,
  I arranged for my public persona to deflect suspicion while receiving praise and political respect.
  In time I moved from a senator representing Naboo to the Republic's Supreme Chancellor,
  and used the power of my office to launch the Clone Wars.
  With Order 66 bringing about the end of the Jedi Order, I declared myself Emperor.
  }.squish

cm = User.create(first_name: 'Charles', last_name: 'Munat', email: 'chasm@ga.co', password: '123', password_confirmation: '123', role: 'master', about_me: about_cm, avatar: seed_image('munat'))
gh = User.create(first_name: 'Grass', last_name: 'Hopper', email: 'gh@ga.co', password: '123', password_confirmation: '123', role: 'apprentice', about_me: about_gh, avatar: seed_image('default-grasshopper'))

ms = User.create(first_name: 'Master', last_name: 'Shifu', email: 'ms@kp.movie', password: '123', password_confirmation: '123', role: 'master', about_me: about_ms, avatar: seed_image('default-master'))

my = User.create(first_name: 'Master', last_name: 'Yoda', email: 'my@jedi.sw', password: '123', password_confirmation: '123', role: 'master', avatar: seed_image('yoda'), about_me: about_my)
ls = User.create(first_name: 'Luke', last_name: 'Skywalker', email: 'ls@jedi.sw', password: '123', password_confirmation: '123', role: 'master', avatar: seed_image('luke'), about_me: about_ls)

dm = User.create(first_name: 'Darth', last_name: 'Maul', email: 'dm@sith.sw', password: '123', password_confirmation: '123', role: 'apprentice', avatar: seed_image('darth_maul'), about_me: about_dm)
ds = User.create(first_name: 'Darth', last_name: 'Sidious', email: 'ds@sith.sw', password: '123', password_confirmation: '123', role: 'master', avatar: seed_image('darth_sidious'), about_me: about_ds)

a1 = Apprenticeship.create(master: gh, apprentice: cm, end_date: (1.month.from_now))
a2 = Apprenticeship.create(master: ds, apprentice: dm, end_date: (20.year.from_now))
Rating.create(rater: gh, ratee: ms, apprenticeship: a2, rating: 5)
Rating.create(rater: ms, ratee: gh, apprenticeship: a1, rating: 3)
skills = ['Ruby on Rails', 'Javascript', 'CSS', 'Bartending', 'Jedi', 'Sith', 'Pascal', 'Kung Fu']

skills.each { |skill| Skill.create(skill_name: skill) }

skills = Skill.all

Proficiency.create!(user: cm, skill: skills[0], proficiency_status: 'has')
Proficiency.create!(user: cm, skill: skills[1], proficiency_status: 'has')
Proficiency.create!(user: cm, skill: skills[2], proficiency_status: 'has')
Proficiency.create!(user: cm, skill: skills[3], proficiency_status: 'has')

Proficiency.create!(user: gh, skill: skills[0], proficiency_status: 'desired')
Proficiency.create!(user: gh, skill: skills[1], proficiency_status: 'desired')
Proficiency.create!(user: gh, skill: skills[2], proficiency_status: 'desired')

Proficiency.create!(user: ms, skill: skills[7], proficiency_status: 'has')

Proficiency.create!(user: my, skill: skills[4], proficiency_status: 'has')
Proficiency.create!(user: ls, skill: skills[4], proficiency_status: 'has')

Proficiency.create!(user: dm, skill: skills[5], proficiency_status: 'desired')
Proficiency.create!(user: ds, skill: skills[5], proficiency_status: 'desired')

c1 = Conversation.create!(created_by: gh, created_for: ms)
Conversation.create!(created_by: gh, created_for: my)
Conversation.create!(created_by: my, created_for: ms)

Message.create!(conversation: c1, recipient: gh, sender: ms, content: 'Hello, I hope to work with you!')
Message.create!(conversation: c1, recipient: ms, sender: gh, content: 'Sure, let me know when you want to meet up!')


