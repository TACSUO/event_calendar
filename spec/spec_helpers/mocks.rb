def mock_event_revision(stubs={})
  @event_revision ||= mock_model(EventRevision, stubs)
end
def mock_event(stubs={})
  @mock_event ||= mock_model(Event, stubs)
end
