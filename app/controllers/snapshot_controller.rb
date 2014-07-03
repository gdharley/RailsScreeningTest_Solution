class SnapshotController < ApplicationController
  def show
    @processApp = ProcessApp.find(params[:pid])
    @snapshot = Snapshot.find(params[:sid])

    @foo = []
    @snapshot.findDependencies(params[:sid], @foo)


    render "/snapshot/show"
  end
end
