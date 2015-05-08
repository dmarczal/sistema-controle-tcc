class Orientation < ActiveRecord::Base
    belongs_to :timeline

    validates :timeline, :presence => {message: 'Uma orientação precisa de um TCC.'}
    validates :title, :presence => {message: 'Uma orientação precisa de um título.'}
    validates :description, :presence => {message: 'Uma orientação precisa de uma descrição.'}
    validates :date, :presence => {message: 'Uma orientação precisa de uma data.'}
end
