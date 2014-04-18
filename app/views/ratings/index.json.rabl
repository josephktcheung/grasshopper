object false

node :links do
  {
    :"ratings.apprenticeship" => {
      href: root_url + "apprenticeships/{ratings.apprenticeship}",
      type: "apprenticeships"
    },
    :"ratings.rater" => {
      href: root_url + "users/{ratings.rater}",
      type: "users"
    },
    :"ratings.ratee" => {
      href: root_url + "apprenticeships/{ratings.ratee}",
      type: "users"
    },
  }
end

child @ratings do
  extends "ratings/show"
end

node :linked do
  users = @ratings.map { |rating| [rating.rater, rating.ratee] }
  users.flatten!.uniq!
  apprenticeship = @ratings.map { |rating| rating.apprenticeship }
  apprenticeship.uniq!
  {
    users: users.map do |user|
      {
        href:     user_url(user),
        id:       user.id,
        username: user.username
      }
    end,

    apprenticeship: apprenticeship.map do |apprenticeship|
      {
        href:   apprenticeship_url(apprenticeship),
        id:     apprenticeship.id,
        master: apprenticeship.master.id,
        apprentice: apprenticeship.apprentice.id,
        end_date: apprenticeship.end_date
      }
    end
  }
end