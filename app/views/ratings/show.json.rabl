collection @rating, root: "ratings", :object_root => false

attributes :id, :rating

node :links do |rating|
  {
    apprenticeship:
      {
        href: apprenticeship_url(rating.apprenticeship),
        id: rating.apprenticeship.id,
        type: "apprenticeships"
      },
    rater:
      {
        href: user_url(rating.rater),
        id: rating.rater.id,
        type: "users"
      },
    ratee:
      {
        href: user_url(rating.ratee),
        id: rating.ratee.id,
        type: "users"
      }
  }
end