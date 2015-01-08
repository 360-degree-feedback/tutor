module ApplicationHelper

  def markdown(text)
    render_options = {
        filter_html: true,
        hard_wrap: true,
    }
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, fenced_code_blocks: true, highlight: true, superscript: true, underline: true, quote: true)
    markdown.render(text).html_safe
  end

  def progress(user)
    # Returns a given user's progress.

    tests = Test.where('user_id = ? AND passed = ?' , user.id, true)
    count = tests.count(:lesson_id, distinct: true)
    total = Lesson.all.count
    return ((count.to_f/total.to_f).round(1)*100).to_i
  end

  def progress_id(user)
    # Find the next lesson which the user should attempt.
    # If they have no Test history, start from scratch.

    tests = Test.where('user_id = ? AND passed = ?', user.id, true)
    latest = tests.maximum('lesson_id')
    next_lesson = Lesson.where('id > ?', latest).first || Lesson.first

    return next_lesson.id || Lesson.first.id
  end
end
