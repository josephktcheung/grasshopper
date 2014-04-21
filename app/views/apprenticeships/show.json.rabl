collection @apprenticeship, root: "apprenticeships", :object_root => false

attributes :id, :end_date, :created_at, :updated_at

node :links do |apprenticeship|
  {
    master: apprenticeship.master.id,
    apprentice: apprenticeship.apprentice.id,
    ratings: apprenticeship.rating_ids
  }
end