require "rails_helper"

describe MoviesController, type: :controller do
  
  describe "#same_director" do
    context "movie has a director" do
      describe "only one movie has that director" do
        let(:id1) {'1'}
        let(:movie1) {instance_double("Movie", title: "title1", director: "director1")}
        before(:each) do
          #@movie = Movie.find params[:id]
          allow(Movie).to receive(:find).with(id1).and_return(movie1)
        end
        it "retrieves the director and only one movie" do
          expect(movie1).to receive(:movies_by_director).
            and_return(director: "director1", movies: [movie1])
          get :same_director, id: id1
        end
        it "makes the results available to template" do
          allow(movie1).to receive(:movies_by_director).
            and_return(director: "director1", movies: [movie1])
          get :same_director, id: id1
          expect(assigns(:director_movies)).to eq(director: "director1", movies: [movie1])
        end
        it "selects the same director template for rendering" do
          allow(movie1).to receive(:movies_by_director).
            and_return(director: "director1", movies: [movie1])
          get :same_director, id: id1
          expect(response).to render_template("same_director")
        end    
      end
      describe "multiple movies have that director" do
        let(:id1) {'1'}
        let(:movie1) {instance_double("Movie", title: "title1", director: "director1")}
        let(:id2) {'2'}
        let(:movie2) {instance_double("Movie", title: "title2", director: "director1")}
        let(:id3) {'3'}
        let(:movie3) {instance_double("Movie", title: "title3", director: "director3")}
        before(:each) do
          #@movie = Movie.find params[:id]
          allow(Movie).to receive(:find).with(id1).and_return(movie1)
        end
        it "retrieves the director and all movies with same director" do
          expect(movie1).to receive(:movies_by_director).
            and_return(director: "director1", movies: [movie1,movie2])
          get :same_director, id: id1          
        end
        it "makes the results available to template" do
          allow(movie1).to receive(:movies_by_director).
            and_return(director: "director1", movies: [movie1,movie2])
          get :same_director, id: id1
          expect(assigns(:director_movies)).to eq(director: "director1", movies: [movie1,movie2])
        end
        it "selects the same director template for rendering" do
          allow(movie1).to receive(:movies_by_director).
            and_return(director: "director1", movies: [movie1,movie2])
          get :same_director, id: id1
          expect(response).to render_template("same_director")
        end    
      end
    end
    context "movie has no director" do
      describe "unable to retrieve director for movie" do
        let(:id1) {'1'}
        let(:movie1) {instance_double("Movie", title: "title1", director: "")}
         before(:each) do
          allow(Movie).to receive(:find).with(id1).and_return(movie1)
        end
        it "retrieves no movie and no director" do
          expect(movie1).to receive(:movies_by_director).and_return(director: "", movies: [])
          get :same_director, id: id1
        end
        it "sets a flash message" do
          allow(movie1).to receive(:movies_by_director).and_return(director: "", movies: [])
          get :same_director, id: id1
          expect(flash[:warning]).to match(/^\'[^']*\' has no director info.$/)
        end
        it "redirects to movies page" do
          allow(movie1).to receive(:movies_by_director).and_return(director: "", movies: [])
          get :same_director, id: id1
          expect(response).to redirect_to(movies_path)
        end
      end
    end
    
  end
end