module XClarityClient
  # update component class
  class UpdateComp < Endpoints::XclarityEndpoint
    BASE_URI = '/updatableComponents'.freeze
    LIST_NAME = 'updateCompList'.freeze

    attr_accessor :DeviceList, :CMMList, :ServerList, :StorageList, :SwitchList,
                  :UpdateStatusMetrics, :TotaldeviceUpdates,
                  :TotaldeviceUpdatesActive, :TotaldeviceUpdatesComplete,
                  :TotaldeviceUpdatesInProgress, :TotalJobs, :TotalJobsComplete,
                  :TotalJobsInProgress, :TotalJobsPercentComplete,
                  :TotalSupportTasks, :TotalSupportTasksActive, :TotalTasks,
                  :TotalTasksBlocked, :TotalTasksCanceled, :TotalTasksComplete,
                  :TotalTasksFailed, :TotalTasksInProgress, :TotalTasksSuccess,
                  :TotalUpdateTasksActive, :TotalUpdateTasks, :result,
                  :messages, :id, :text
  end
end
