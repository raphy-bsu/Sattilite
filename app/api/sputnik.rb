module Sputnik
  class API < Grape::API
    mount V1::Base
  end
end
