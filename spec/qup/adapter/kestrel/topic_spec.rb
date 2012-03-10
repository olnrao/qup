require 'spec_helper'
require 'qup/shared_topic_examples'

describe 'Qup::Adapter::Kestrel::Topic', :kestrel => true do
  include_context "Qup::Adapter::Kestrel"
  include_context "Qup::Topic"
  it_behaves_like Qup::TopicAPI
end
