class FixturesController < ApplicationController

  def show
    @fixture = Fixture.find(params[:id])
    @group = @fixture.group
    @matches = Match.where(fixture: @fixture)
  end

end
