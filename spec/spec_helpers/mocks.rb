def mock_event_revision(stubs={})
  @event_revision ||= mock_model(EventRevision, stubs)
end
