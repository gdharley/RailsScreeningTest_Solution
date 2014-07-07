class SnapshotController < ApplicationController
  def show
    @processApp = ProcessApp.find(params[:pid])
    @snapshot = Snapshot.find(params[:sid])

    @deps = []   # list of dependant snapshots
    @cyclic = [] # List of cyclic dependencies (potential issue)
    @spiral =[]  # List of illegal "spiral" dependencies
    @depTk = {}  # Map (processApp.id : snapshot.id})of dependant toolkits. Used to determine spiral dependencies

    @snapshot.findDependencies(params[:sid], @deps, @cyclic, @spiral, @depTk)


    render "/snapshot/show"
  end
end
