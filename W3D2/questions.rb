require 'sqlite3'
require 'singleton'
require 'active_support/inflector'

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')

    self.type_translation = true
    self.results_as_hash = true
  end
end

class ModelBase
  def self.find_by_id(id)
    model = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{self.to_s.tableize}
      WHERE
        id = ?
    SQL

    return nil if model.empty?

    self.new(model.first)
  end

  def self.all
    models = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        *
      FROM
        #{self.to_s.tableize}
    SQL
    return nil if models.empty?

    models.map { |m| self.new(m) }
  end
end

class User < ModelBase
  attr_accessor :fname, :lname

  def self.find_by_name(fname, lname)
    users = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ? AND lname = ?
    SQL

    return nil if users.empty?

    users.map { |user| User.new(user) }
  end

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def save
    if @id
      QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname, @id)
        UPDATE
          users
        SET
          fname = ?, lname = ?
        WHERE
          id = ?
      SQL
    else
      QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname)
        INSERT INTO
          users (fname, lname)
        VALUES
          (?, ?)
      SQL
      @id = QuestionsDatabase.instance.last_insert_row_id
    end
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(@id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end

  def average_karma
    karma = QuestionsDatabase.instance.execute(<<-SQL, @id)
      SELECT
        CAST(COUNT(liked_by_id) AS FLOAT) / COUNT(DISTINCT(questions.id)) AS avg
      FROM
        questions
      LEFT JOIN question_likes
        ON question_likes.question_id = questions.id
      WHERE
        author_id = ?
    SQL

    karma.first['avg']
  end
end

class Question < ModelBase
  attr_accessor :title, :body, :author_id

  def self.find_by_author_id(author_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        questions
      WHERE
        author_id = ?
    SQL

    return nil if questions.empty?

    questions.map { |q| Question.new(q) }
  end

  def self.most_followed(n)
    QuestionFollow.most_followed_questions(n)
  end

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author_id = options['author_id']
  end

  def save
    if @id
      QuestionsDatabase.instance.execute(<<-SQL, @title, @body, @author_id, @id)
        UPDATE
          questions
        SET
          title = ?, body = ?, author_id = ?
        WHERE
          id = ?
      SQL
    else
      QuestionsDatabase.instance.execute(<<-SQL,  @title, @body, @author_id)
        INSERT INTO
          questions (title, body, author_id)
        VALUES
          (?, ?, ?)
      SQL
      @id = QuestionsDatabase.instance.last_insert_row_id
    end
  end

  def author
    User.find_by_id(@author_id)
  end

  def replies
    Reply.find_by_question_id(@id)
  end

  def followers
    QuestionFollow.followers_for_question_id(@id)
  end

  def likers
    QuestionLike.likers_for_question_id(@id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(@id)
  end
end

class QuestionFollow < ModelBase
  attr_accessor :question_id, :followed_by_id

  def self.followers_for_question_id(question_id)
    followers = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      users.id
    FROM
      question_follows
    JOIN users ON question_follows.followed_by_id = users.id
    WHERE
      question_follows.question_id = ?
    SQL

    return nil if followers.empty?

    followers.map { |follower| User.find_by_id(follower['id']) }
  end

  def self.followed_questions_for_user_id(user_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
    SELECT
      *
    FROM
      question_follows
    JOIN questions ON question_follows.question_id = questions.id
    WHERE
      question_follows.followed_by_id = ?
    SQL

    return nil if questions.empty?

    questions.map { |q| Question.new(q) }
  end

  def self.most_followed_questions(n)
    questions = QuestionsDatabase.instance.execute(<<-SQL, n)
    SELECT
      questions.id
    FROM
    question_follows
    JOIN questions ON question_follows.question_id = questions.id
    GROUP BY
      question_follows.question_id
    ORDER BY
      COUNT(*) DESC
    LIMIT
      ?
    SQL

    return nil if questions.empty?

    questions.map { |q| Question.find_by_id(q['id']) }
  end

  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @followed_by_id = options['followed_by_id']
  end
end

class Reply < ModelBase
  attr_accessor :question_id, :author_id, :parent_id, :body

  def self.find_by_user_id(user_id)
    replies = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        replies
      WHERE
        author_id = ?
    SQL

    return nil if replies.empty?

    replies.map { |reply| Reply.new(reply) }
  end

  def self.find_by_question_id(question_id)
    replies = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        question_id = ?
    SQL

    return nil if replies.empty?

    replies.map { |reply| Reply.new(reply) }
  end

  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @author_id = options['author_id']
    @parent_id = options['parent_id']
    @body = options['body']
  end

  def save
    if @id
      QuestionsDatabase.instance.execute(<<-SQL, @question_id, @author_id, @parent_id, @body, @id)
        UPDATE
          replies
        SET
          question_id = ?, author_id = ?, parent_id = ?, body = ?
        WHERE
          id = ?
      SQL
    else
      QuestionsDatabase.instance.execute(<<-SQL, @question_id, @author_id, @parent_id, @body)
        INSERT INTO
          replies (question_id, author_id, parent_id, body)
        VALUES
          (?, ?, ?, ?)
      SQL
      @id = QuestionsDatabase.instance.last_insert_row_id
    end
  end

  def author
    User.find_by_id(@author_id)
  end

  def question
    Question.find_by_id(@question_id)
  end

  def parent_reply
    Reply.find_by_id(@parent_id)
  end

  def child_replies
    replies = QuestionsDatabase.instance.execture(<<-SQL, @parent_id)
    SELECT
      *
    FROM
      replies
    WHERE
      parent_id = ?
    SQL

    replies.map { |reply| Reply.new(reply) }
  end
end

class QuestionLike < ModelBase
  attr_accessor :question_id, :liked_by_id

  def self.most_liked_questions(n)
    questions = QuestionsDatabase.instance.execute(<<-SQL, n)
    SELECT
      questions.id
    FROM
    question_likes
    JOIN questions ON question_likes.question_id = questions.id
    GROUP BY
      question_likes.question_id
    ORDER BY
      COUNT(*) DESC
    LIMIT
      ?
    SQL

    return nil if questions.empty?

    questions.map { |q| Question.find_by_id(q['id']) }
  end

  def self.likers_for_question_id(question_id)
    users = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        liked_by_id
      FROM
        question_likes
      WHERE
        question_id = ?
    SQL

    return nil if users.empty?

    users.map { |u| User.find_by_id(u['id']) }
  end

  def self.num_likes_for_question_id(question_id)
    likes = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        COUNT(*) AS num
      FROM
        question_likes
      WHERE
        question_id = ?
      GROUP BY
        question_id
    SQL

    likes.first['num']
  end

  def self.liked_questions_for_user_id(user_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        question_id
      FROM
        question_likes
      WHERE
        liked_by_id = ?
    SQL

    return nil if questions.empty?

    questions.map { |q| Question.find_by_id(q['question_id']) }
  end

  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @liked_by_id = options['liked_by_id']
  end
end
