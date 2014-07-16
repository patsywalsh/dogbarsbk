class Place < ActiveRecord::Base
	geocoded_by :address
	after_validation :geocode
	acts_as_commontable
end


