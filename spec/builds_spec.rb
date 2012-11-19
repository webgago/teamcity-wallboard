require "spec_helper"
describe Builds do

  let(:client) { double('client') }

  before do
    client.stub(:build).and_return({ 'id'         => '1',
                                     'buildType'  => { 'id' => 'bt1', 'projectName' => 'ProjectName1', 'name' => 'BuildName1' },
                                     'status'     => 'FAILURE',
                                     'statusText' => 'text2',
                                     'startDate'  => '20121117T201959+0400',
                                     'changes'    => { 'href' => '/changes?build=id:188' } },

                                   { 'id'         => '2',
                                     'buildType'  => { 'id' => 'bt2', 'projectName' => 'ProjectName2', 'name' => 'BuildName2' },
                                     'status'     => 'SUCCESS',
                                     'statusText' => 'text1',
                                     'startDate'  => '20121117T202021+0400',
                                     'changes'    => { 'href' => '/changes?build=id:189' } })

    client.stub(build_types: %w(id1 id2))
    client.stub(:commiters).and_return(%w(commiter1 commiter2), %w(commiter3))
  end

  subject { Builds.new client }

  it "should return latest build names for each build type" do
    subject.latest.map { |b| b['name'] }.should eql ["ProjectName1 BuildName1",
                                                     "ProjectName2 BuildName2"]
  end

  it "should return latest build statuses for each build type" do
    subject.latest.map { |b| b['status'] }.should eql %w(failure success)
  end

  it "should return latest build authors for each build type" do
    subject.latest.map { |b| b['commiters'] }.should eql [%w(commiter1 commiter2), %w(commiter3)]
  end

  it "should return latest build status text for each build type" do
    subject.latest.map { |b| b['status_text'] }.should eql %w(text2 text1)
  end

  it "should return latest build id for each build type" do
    subject.latest.map { |b| b['id'] }.should eql %w(1 2)
  end

  it "should return latest build start dates for each build type" do
    subject.latest.map { |b| b['start_date'] }.should eql ["2012-11-17T16:19:59+00:00", "2012-11-17T16:20:21+00:00"]
  end
end
