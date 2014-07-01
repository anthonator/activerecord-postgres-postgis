class Foo < ActiveRecord::Base
  spatial :bar, :preferred

  spatial :car, :simple_mercator
end
