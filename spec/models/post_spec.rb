require 'rails_helper'

RSpec.describe Post do
 
 
  describe "Association" do
    it {  should belong_to(:user) }
  end
  
end
