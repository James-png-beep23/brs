defmodule BrsWeb.ViewHelpers do
  def full_name(%Brs.Accounts.User{} = user) do
    "#{user.first_name} #{user.surname} #{user.last_name}"
  end

  def full_name(%Brs.Businesses.BusinessOwner{} = user) do
    "#{user.first_name} #{user.other_names} #{user.last_name}"
  end

  def full_name(_), do: nil

  def date_format(datetime) do
    Timex.format!(datetime, "{Mfull} {D}, {YYYY} {h12}:{m} {AM}")
  end

  def date_format_sht(datetime) do
    Timex.format!(datetime, "{Mshort} {D}, {YYYY}")
  end

   def date_time_format_sht(datetime) do
    Timex.format!(datetime, "{Mshort} {D}, {YYYY} {h12}:{m} {AM}")
  end

  def can?(user, action, resource) do
    Brs.Policies.Can.can?(user, action, resource)
  end
end
