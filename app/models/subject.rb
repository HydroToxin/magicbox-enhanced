# frozen_string_literal: true

# Subject
class Subject < ApplicationRecord
  include BirthTypeEnum

  belongs_to :grow
  belongs_to :room, optional: true

  has_many :observations
  has_many :resource_datas, through: :observations
  has_many :issues, through: :observations
  has_many :scenarios, dependent: :destroy
  has_many :events, as: :eventable, dependent: :destroy

  belongs_to :strain, optional: true

  belongs_to :mother, optional: true, class_name: 'Subject', dependent: :destroy
  has_many :clones, class_name: 'Subject'

  validates :name, presence: true

  def name_with_grow
    "#{fullname} [Grow##{grow_id}]"
  end

  def generate_qr(size)
    require 'barby'
    require 'barby/barcode'
    require 'barby/barcode/qr_code'
    require 'barby/outputter/png_outputter'

    barcode = Barby::QrCode.new("#{Setting.app_hostname}/grows/#{grow.id}/subjects/#{id}/observations/new",
                                level: :q, size: 6)
    "data:image/png;base64,#{Base64.strict_encode64(barcode.to_png({ xdim: size }))}"
  end

  def generate_barecode
    require 'barby'
    require 'barby/barcode'
    require 'barby/barcode/code_128'

    "data:image/png;base64,#{Base64.strict_encode64(Barby::Code128B.new(id.to_s).to_png)}"
  end

  def fullname
    "##{id} - #{name}"
  end

  def strain_name
    strain.nil? ? '' : strain.name
  end
end
