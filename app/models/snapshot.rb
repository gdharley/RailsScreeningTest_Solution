class Snapshot < ActiveRecord::Base
  belongs_to :process_app
  has_many :process_dependencies, class_name: 'Dependency', foreign_key: 'toolkit_snap_id'
  has_many :toolkit_dependencies, class_name: 'Dependency', foreign_key: 'proc_app_snap_id'
  has_many :toolkit_snaps,		:through => :toolkit_dependencies
  has_many  :process_snaps,		:through => :process_dependencies

  attr_accessible :guid, :name, :process_app_id, :type

  def findDependencies(sid, dList)

    @dependencies = Dependency.find_all_by_proc_app_snap_id(sid)
    @dependencies.each do |dependency|
      snapshot = Snapshot.find(dependency.toolkit_snap_id)
      if !dList.include?(snapshot)
        dList << snapshot
        self.findDependencies(snapshot.id, dList)
      end
    end

  end

end
