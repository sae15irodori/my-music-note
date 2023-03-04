class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :notes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :note_comments, dependent: :destroy

 has_one_attached :image

  #def get_image
    #unless image.attached?
      #file_path = Rails.root.join('app/assets/images/no-image.jpg')
      #image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    #end
    #image.variant(resize_to_limit: [100, 100]).processed
  #end



  def self.guest#ゲストのレコードを作成するメソッド
    find_or_create_by!(email: 'aaa@aaa.com') do |user|#aaa@aaa.comがなければアドレスを自動生成？userへ格納
      user.password = SecureRandom.urlsafe_base64     #psswordはnull:falseなのでランダムにパスワードを生成
      user.password_confirmation = user.password      #確認用パスワードに↑で生成したパスワード渡す
      user.name = 'サンプル'                          #nameもnull:falseなのでサンプルという名前を渡す
    end
  end

end
