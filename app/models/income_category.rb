class IncomeCategory < ActiveHash::Base
  self.data = [
    {id: 1, name: '給与'}, {id: 2, name: '事業・副業'}
  ]
end