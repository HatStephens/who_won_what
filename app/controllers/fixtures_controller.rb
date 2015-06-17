class FixturesController < ApplicationController

  def show
    @fixture = Fixture.find(params[:id])
    @matches = Match.where(fixture: @fixture)
  end

end
