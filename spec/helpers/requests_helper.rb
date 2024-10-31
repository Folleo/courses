module RequestsHelper
  def create_author
    Author.create(first_name: "John", last_name: "Doe")
  end

  def create_author_with_courses(courses_number)
    author = create_author
    course = Course.create(name: "Super", description: "Course", author: author)
    courses_number.times do |number|
      course.topics << create_topic(name: "Topic #{number}")
    end
    author
  end

  def create_course
    course = Course.create(name: "Super", description: "Course", author: create_author)
    course.topics << create_topic
    course
  end

  def create_topic(name: "Ruby")
    Topic.create(name: name, description: "Learning #{name}")
  end
end
