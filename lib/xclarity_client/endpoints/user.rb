module XClarityClient
  class User < Endpoints::XclarityEndpoint
    BASE_URI = '/userAccounts'.freeze
    LIST_NAME = 'usersList'.freeze
    SUB_URIS = {
      changePassword: "#{BASE_URI}/passwordChange"
    }

    attr_accessor :response, :PasswordChangeFirstAccess, :activeSessions, :createTimestamp, :description, :groups,
    :id, :lastLoginTimestamp, :ldapDn, :loginAttempts, :loginCount, :modifyTimestamp, :pwExpirationWarning,
    :pwExpired, :pwdAge, :reserved, :state, :supervisor, :timeBeforeExpirationInDays, :userName, :userPw,
    :result, :messages
  end
end
