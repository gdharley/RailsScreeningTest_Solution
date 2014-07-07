class Snapshot < ActiveRecord::Base
  belongs_to :process_app
  has_many :process_dependencies, class_name: 'Dependency', foreign_key: 'toolkit_snap_id'
  has_many :toolkit_dependencies, class_name: 'Dependency', foreign_key: 'proc_app_snap_id'
  has_many :toolkit_snaps,		:through => :toolkit_dependencies
  has_many  :process_snaps,		:through => :process_dependencies

  attr_accessible :guid, :name, :process_app_id, :type

  def findDependencies(sid, dList, cyclic, spiral, depTks)

    @dependencies = Dependency.find_all_by_proc_app_snap_id(sid)
    @dependencies.each do |dependency|
      # retrieve dependant snapshot from the "child" id
      snapshot = Snapshot.find(dependency.toolkit_snap_id)

      if depTks.has_key?(Toolkit.find(snapshot.process_app_id).id) && depTks[Toolkit.find(snapshot.process_app_id).id] != snapshot.id
        spiral << snapshot
      else
        depTks[Toolkit.find(snapshot.process_app_id).id] = snapshot.id
      end

      # add to list of dependencies
      if !dList.include?(snapshot)
        # check if process app/toolkit reference exists
        dList << snapshot
        self.findDependencies(snapshot.id, dList, cyclic, spiral, depTks)
      else
        # Snapshot already listed as a dependency, add it to the cyclic array
        if !cyclic.include?(snapshot)
          cyclic << snapshot
        end
      end
    end

  end

end
