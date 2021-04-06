require "rails_helper"
describe Movie, type: :model do
  describe "#movies_by_director" do
    let(:movie1) {Movie.new}
    it "is an instance method" do
      expect(movie1).to respond_to(:movies_by_director)
    end 
  end
  context "no other movies by that director" do
    let(:movie1) {Movie.new(:director => "director1")}
    it "finds one movie by that director" do
      allow(movie1).to receive(:director).and_return("director1")
      allow(Movie).to receive(:where).with(:director => "director1").and_return([movie1])
      expect(movie1.movies_by_director).to eq({director: "director1", movies: [movie1]})
    end   
  end
  context "other movies by that director" do
    let(:movie1) {Movie.new(:director => "director1")}
    let(:movie2) {Movie.new(:director => "director1")}
    let(:movie3) {Movie.new(:director => "director2")}
    it "finds multiple movies by that director" do
      allow(movie1).to receive(:director).and_return("director1")
      allow(Movie).to receive(:where).with(:director => "director1").and_return([movie1,movie2])
      expect(movie1.movies_by_director).to eq({director: "director1", movies: [movie1,movie2]})
    end   
  end
  context "movie with no director" do
    let(:movie1) {Movie.new(:director => nil)}
    before {allow(movie1).to receive(:director).and_return(nil)}
    it "finds no director for the movie" do
      expect(movie1.movies_by_director).to eq({director: nil, movies: []})
    end
  end
end