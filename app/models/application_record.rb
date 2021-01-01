# Superclase para todos los modelos.
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
