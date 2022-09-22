require 'space_repository'

describe SpaceRepository do
    let(:repo) {SpaceRepository.new}

  it 'returns all spaces' do

    spaces = repo.all

    expect(spaces.length).to eq 5
    expect(spaces.first.id).to eq 1
    expect(spaces.first.user_id).to eq 1
    expect(spaces.first.name).to eq 'Super fancy awesome apartment'
    expect(spaces.first.description).to eq (
      'The best in the neighbourhood, large fridge and awesome view.')  
  end

  describe '#create' do
    it 'creates a record from Space class' do
      space = Space.new
      space.user_id = 1
      space.name = 'Space name'
      space.description = 'The best space ever'
      repo.create(space)
      
      expect(repo.all.length).to eq 6
      last_space = repo.all.last

      expect(last_space.id).to eq 6
      expect(last_space.user_id).to eq 1
      expect(last_space.name).to eq 'Space name'
      expect(last_space.description).to eq 'The best space ever'
    end
  end
end