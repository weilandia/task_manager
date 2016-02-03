require_relative "../test_helper"

class TaskManagerTest < Minitest::Test
  include TestHelpers

  def test_can_create_a_task
    data = {
      title:       "some title",
      description: "some description"
    }

    task_manager.create(data)

    task = task_manager.all.last

    assert task.id
    assert_equal "some title", task.title
    assert_equal "some description", task.description
  end

  def test_can_list_all_tasks
    3.times do
      data = {
        title:       "some title",
        description: "some description"
      }

      task_manager.create(data)
    end

    assert_equal 3, task_manager.all.length
  end


  def test_can_find_specific_task
    3.times do
      data = {
        title:       "some title",
        description: "some description"
      }

      task_manager.create(data)
    end

    assert_equal Task, task_manager.find(3).class
    assert_equal 3, task_manager.find(3).id
  end

  def test_can_update_task
    data = {
      title:       "some title",
      description: "some description"
    }

    task_manager.create(data)
    update_data = { title: "update", description: "some description" }

    task_manager.update(1, update_data)

    assert_equal "update", task_manager.find(1).title
  end

  def test_can_delete_specific_task
    data = {
      title:       "some title",
      description: "some description"
    }

    task_manager.create(data)

    task_manager.delete(1)

    assert task_manager.all.empty?
  end
end
