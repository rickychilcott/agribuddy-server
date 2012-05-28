require 'spec_helper'

describe "routing to markets" do
  it "routes /markets to markets#index" do
    { get: "/markets" }.should route_to(
      controller: "markets",
      action: "index"
    )
  end

  it "routes /markets/:fmid.json to markets#show fmid" do
    { get: "/markets/1" }.should route_to(
      controller: "markets",
      action: "show",
      id: "1"
    )
  end
  
  it "does not expose a create method" do
    { post: "/markets" }.should_not be_routable
  end

  it "does not expose a delete method" do
    { put: "/markets/1" }.should_not be_routable
  end
end