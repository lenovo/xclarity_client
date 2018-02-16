module XClarityClient
  class UpdateComp
    include XClarityClient::Resource

    BASE_URI = '/updatableComponents'.freeze
    LIST_NAME = 'updateCompList'.freeze

    attr_accessor :DeviceList, :CMMList, :ServerList, :StorageList, :SwitchList, :UpdateStatusMetrics, :TotaldeviceUpdates, :TotaldeviceUpdatesActive, :TotaldeviceUpdatesComplete, :TotaldeviceUpdatesInProgress, :TotalJobs, :TotalJobsComplete, :TotalJobsInProgress, :TotalJobsPercentComplete, :TotalSupportTasks, :TotalSupportTasksActive, :TotalTasks, :TotalTasksBlocked, :TotalTasksCanceled, :TotalTasksComplete, :TotalTasksFailed, :TotalTasksInProgress, :TotalTasksSuccess, :TotalUpdateTasksActive, :TotalUpdateTasks, :result, :messages, :id, :text

    def initialize(attributes)
      build_resource(attributes)
    end

  end
end
