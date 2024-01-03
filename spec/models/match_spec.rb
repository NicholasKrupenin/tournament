require 'rails_helper'

RSpec.describe Match, type: :model do
  it { should belong_to(:team) }

  it { should define_enum_for(:status) }
  it { should define_enum_for(:game) }
end
