Spree::Payment.class_eval do
  has_one :adjustment, :as => :source, :dependent => :destroy

  # for Cash on Delivery
  def build_source
    return unless new_record?

    if source_attributes.present? && source.blank? && payment_method.try(:payment_source_class)
      self.source = payment_method.payment_source_class.new(source_attributes)
      self.source.payment_method_id = payment_method.id
      self.source.user_id = self.order.user_id if self.order
    end

    if payment_method and payment_method.respond_to?(:post_create)
      payment_method.post_create(self)
    end

  end

end