class Book < ApplicationRecord
  validates :title,
            presence: { message: "を入力してください" },
            length: { maximum: 100, message: "は100文字以内で入力してください" }

  validates :author,
            presence: { message: "を入力してください" },
            length: { maximum: 50, message: "は50文字以内で入力してください" }

  validates :published_on,
            presence: { message: "を入力してください" }

  validates :description,
            length: { maximum: 1000, message: "は1000文字以内で入力してください" }

  validate :published_on_cannot_be_in_the_future

  private

  def published_on_cannot_be_in_the_future
    return if published_on.blank?

    if published_on > Date.current
      errors.add(:published_on, "は未来の日付にできません")
    end
  end
end