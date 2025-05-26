defmodule BrsWeb.Footer do
  use Phoenix.Component

  def footer(assigns) do
    ~H"""
    <footer class="bg-primary-500 py-10 ">
      <div class="max-w-7xl mx-auto px-4 ">
        <div class="w-5/6 mx-auto text-white grid grid-cols-12 gap-7 ">
          <div class="pb-3 col-span-12 ">
            <img
              alt="Registrar of Societies "
              class="inline-block h-9 "
              src="https://kbrs.pesaflow.com/resources/download/brs-kenya-footer"
            />
          </div>
          <div class="col-span-12 sm:col-span-6 md:col-span-4 ">
            <p class="font-normal text-xs sm:text-sm ">Business Registration Service (BRS) 316</p>
            <p class="font-normal text-xs sm:text-sm ">UpperHill Chambers, 17th Floor</p>
          </div>
          <div class="col-span-12 sm:col-span-6 md:col-span-4 md:text-center ">
            <div class="inline-block text-left ">
              <p class="font-normal text-xs sm:text-sm ">Email: eo@brs.go.ke</p>
              <p class="font-normal text-xs sm:text-sm ">Phone: +254 (020) 2227461</p>
            </div>
          </div>
          <div class="col-span-12 sm:col-span-6 md:col-span-4 md:text-right ">
            <div class="inline-block text-left ">
              <p class="font-normal text-xs sm:text-sm ">Fax: +254 (020) 111 234 567</p>
              <p class="font-normal text-xs sm:text-sm ">Mobile: +254 0711944555</p>
            </div>
          </div>
        </div>
      </div>
    </footer>
    """
  end
end
