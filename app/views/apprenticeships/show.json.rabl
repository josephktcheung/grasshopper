collection @apprenticeship, root: "apprenticeships", :object_root => false

attributes :id, :end_date, :status, :created_at, :updated_at

node :links do |apprenticeship|
  {
    master:
      {
        href: user_url(apprenticeship.master),
        id: apprenticeship.master.id,
        first_name: apprenticeship.master.first_name,
        last_name: apprenticeship.master.last_name,
        type: "users"
      },

    apprentice:
      {
        href: user_url(apprenticeship.apprentice),
        id: apprenticeship.apprentice.id,
        first_name: apprenticeship.apprentice.first_name,
        last_name: apprenticeship.apprentice.last_name,
        type: "users"
      },

    ratings:
      apprenticeship.ratings.map do |rating|
        {
          href: rating_url(rating),
          id: rating.id,
          type: "ratings"
        }
      end
  }
end

