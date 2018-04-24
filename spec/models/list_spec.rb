require 'rails_helper'

RSpec.describe List, type: :model do
  describe "#complete_all_tasks!" do
    it "should mark all tasks as complete" do
      list = List.create(name: "Chores")
      Task.create(complete: false, list_id: list.id)
      Task.create(complete: false, list_id: list.id)
      list.complete_all_tasks!
      list.tasks.each do |task|
        expect(task.complete).to eq(true)
      end
    end
  end

  describe "#snooze_all_tasks!" do
    it "should increase all deadlines by 1 hour" do
      list = List.create
      Task.create(deadline: Time.new(2015, 1, 1), list_id: list.id)
      Task.create(deadline: Time.new(2015, 1, 1), list_id: list.id)
      Task.create(deadline: Time.new(2015, 1, 1), list_id: list.id)
      list.snooze_all_tasks!
      list.tasks.each do |task|
        expect(task.deadline).to eq(Time.new(2015, 1, 1) + 1.hour)
      end
    end
  end

  describe "#total_duration" do
    it "should return the sum of all task durations" do
      list = List.create
      Task.create(duration: 50, list_id: list.id)
      Task.create(duration: 150, list_id: list.id)
      expect(list.total_duration).to eq(200)
    end
  end

  describe "#incomplete_tasks" do
    it "should return an array of incomplete tasks" do
      list  = List.create
      Task.create(complete: true, list_id: list.id)
      Task.create(complete: false, list_id: list.id)
      Task.create(complete: false, list_id: list.id)
      Task.create(complete: false, list_id: list.id)
      expect(list.incomplete_tasks.length).to eq(3)
    end
  end

  describe "#favorite_tasks" do
    it "should return an array of incomplete tasks" do
      list  = List.create
      Task.create(favorite: true, list_id: list.id)
      Task.create(favorite: false, list_id: list.id)
      Task.create(favorite: false, list_id: list.id)
      Task.create(favorite: false, list_id: list.id)
      Task.create(favorite: true, list_id: list.id)
      expect(list.favorite_tasks.length).to eq(2)
    end
  end
end
