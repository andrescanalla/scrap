class ProductosController < ApplicationController
  require 'watir'
  require 'nokogiri'
  def preguntar
  end

  before_action :set_producto, only: [:show, :edit, :update, :destroy]
  def buscar
    #$browser= Watir::Browser.new(:chrome)
    #$browser.goto("https://www.carters.com/my-account?id=carters")
    #sleep 60
  end
  def buscar2
    #sleep 60
  end
  def abrir_brow
     $browser= Watir::Browser.new(:chrome)
  end
  def comparar_hym
    doc = Nokogiri::XML.parse($browser.html)
    if doc.css('[class="infoBlock package pane "]').count==1
        $ordhym=doc.css('[class="infoBlock package pane "]')
    else
        $ordhym=doc.css('[class="infoBlock package pane"]')
    end
    $ordlimp=$ordhym.css("ul:nth-child(3)")
    $imas=$ordhym.css("ul:nth-child(2) img[2]") #imagenes
    $descr=$ordhym.css("h3") # Descripciones
    # $pres=$ordhym.css("ul:nth-child(2) span[2] span[1]") #precio por unidad
    $pres=$ordhym.css('[class="priceTotal"] span') #precio total
    #byebug
    u=0
    $liscods=0
    $liscods=[]
    $lista=0
    $lista=[]
    $lisq=0
    $lisq=[]
    $ordlimp.map do |li|
      $liscods[u]=li.css("li[4] span[2]").text #Nº de articulos
      $lista[u]=li.css("li[3] span[2]").text #Talles
      $lisq[u]=li.css("li[1] span[2]").text #Cantidades
      u=u+1
    end
  u=0
  $imal=0
  $imal=[]
  $imas.map do |li|
    $imal[u]=li.attr('src').gsub('small','large')
    u=u+1
  end
  u=0
  $prel=0
  $prel=[]
  $pres.map do |li|
    $prel[u]=li.text[1,10]
    u=u+1
  end
  u=0
  $descrl=0
  $descrl=[]
  $descr.map do |li|
    $descrl[u]=li.css("span[1]").text.split("$").first 
    u=u+1
  end
  #byebug
  #$browser.a(href: "//www.hm.com/us/logout").click
  #sleep 5
  $browser.goto("http://www.hm.com/us/quickorder")
  sleep 5
  n=0
  $liscodl=0
  $liscodl=[]
  $liscodf=0
  $liscodf=[]
  $prod=0
  $prod=[]
  sleep 4
  $liscods.map do |cs|
      $browser.text_field(:id => 'input-articleNumber-0').set(cs)
      sleep 2
      $browser.text_field(:id => 'input-articleNumber-1').set()
      sleep 3
      doc = Nokogiri::XML.parse($browser.html)
      sleep 2
      if doc.css('[class="error"]').count==6
        $liscodf[n]="xxxxxx"
        # $prod[n]="This article number doesn’t exist. Please try again."
      else
      $liscodl[n]=doc.css('[class="imageItem"] button').attr('data-article').value #codigo de prenda incompleto sin talle
      $liscodf[n]=$liscodl[n]+$lista[n] #codigo de prenda completo (producto + talle)
      # $prod[n]=doc.css("h2")[1].text[0,80].strip #nombre de prenda
      end
      sleep 1
      n=n+1
  end
  $browser.goto("https://www.hm.com/us/my-hm/mypurchases")
    render "/productos/comparar_hym"
end

  def comparar
  doc = Nokogiri::XML.parse($browser.html)
  #det = doc.css("table:nth-child(9) tbody") #  buscamos la tabla y sacamos el head para que nos queden las 12 filas "tr"
  det=doc.css('[class="orderDetailRows"]')[0]
  #@rows = det.css("tr")
  @rows=det.css('[class="cart-row"]')
  render "/productos/comparar"
  end


  def importar
    @marca=params[:marca]
      d=params[:id_tipo]
      d.map do |dd|
        $d1=dd
      end
      $d1.map do |dd|
        $d2=dd
      end
      @tipo=$d2

    if @marca=="1"
        @n=0 # producto nuevo
        @a=0 #producto actualizado
        @o=0 #Detallo Orden creada
        @s=0  #Stock creado
         #1 = Carters
        #browser.text_field(:type => 'email').set('pasquinelli@a-w-a.com.ar')
        #sleep 2
        #browser.text_field(:type => 'password').set('Clandestina2')
        #flash[:notice] = "haz el Login y selecciona la orden a importar"
        #redirect_to :back
        #sleep 10
        doc = Nokogiri::XML.parse($browser.html)
        #doc = Nokogiri::XML.parse($br)
        $ord=Orden.new
        $ord.id_pedidos=Pedido.last.idpedidos
        $ord.orden=doc.css('[class="grayBox"] h2')[0].text[9,50]
        tofecha=Date.strptime(doc.css('[class="grayBox"] div span[3]').text , "%m/%d/%Y")
        $ord.fecha=tofecha.to_formatted_s(:db)
        $ord.save

        #det = doc.css("table:nth-child(9) tbody") #  buscamos la tabla y sacamos el head para que nos queden las 12 filas "tr"
        det=doc.css('[class="orderDetailRows"]')[0]
        #rows = det.css("tr")
        rows=det.css('[class="cart-row"]')

        rows.map do |row|
          #codebar_sucio=row.at_css("td:nth-child(5) a").attr('href')
          codebar_sucio=row.css('[class="item-write-review"] a').attr('href').value
          @i_codebar_final=codebar_sucio[-28,12]
          @i_imagen=row.css('[class="item-image"] img').attr('src').value
          @i_producto=row.css('[class="product-name"]').text
          @i_style=row.css('[class="sku"] b').text
          @i_talle=row.css('[class="attribute Size"] span[2]').text
           #@i_stock==row.css("td[2]").text.strip!
          @i_cant=row.css('[class="item-quantity desktopvisible"]').text.strip!
          @i_precio=row.css('[class="item-total strong desktopvisible"]').text.strip[1,10]


          @buscapro=Producto.where(codebar:  @i_codebar_final).first
          if @buscapro.blank?
            # @buscapro es = vacio ->no existe codebar igual
            pro=Producto.new
            pro.imagen=@i_imagen
            pro.producto=@i_producto
            pro.style=@i_style
            pro.talle=@i_talle
            pro.codebar=@i_codebar_final
            pro.save
            @n=@n+1
            idpro=Producto.find(pro.idproducto)
            deta=Detalleorden.new
            deta.id_orden=$ord.idorden
            deta.id_tipo=@tipo
            deta.id_producto=idpro.idproducto
            deta.cant=@i_cant
            deta.precio=@i_precio
            #deta.id_tipo como predetrminado esta en 1
            deta.save
            @o=@o+1
            i=0
            while i < deta.cant do
            sto=Stock.new
            sto.id_detalleorden=deta.iddetalleorden
            sto.stock=1
            sto.estado="Comprado"
            sto.save
            i=i+1
            @s=@s+1
            end
          else
            @buscapro.imagen=@i_imagen # row.at_css("td div img").attr('src')
            @buscapro.producto=@i_producto #row.at_css("td div:nth-child(2) div").text
            @buscapro.style=@i_style #row.at_css("td div:nth-child(2) span").text[6,30]
            @buscapro.talle=@i_talle #row.at_css("td div:nth-child(3)").text[5,20]
            @buscapro.codebar=@i_codebar_final #codebar_final
              #buscapro.stock + row.css("td[2]").text.strip!
            @buscapro.save
            @a=@a+1
            idpro=Producto.find(@buscapro.idproducto)
            deta=Detalleorden.new
            deta.id_orden=$ord.idorden
            deta.id_tipo=@tipo
            deta.id_producto=idpro.idproducto
            deta.cant=@i_cant
            deta.precio=@i_precio
            #deta.id_tipo como predetrminado esta en 1
            deta.save
            @o=@o+1
            i=0
            while i < deta.cant do
            sto=Stock.new
            sto.id_detalleorden=deta.iddetalleorden
            sto.stock=1
            sto.estado="Comprado"
            sto.save
            i=i+1
            @s=@s+1
            end
          end
        end

        dos=Detalleorden.where id_producto: 1 
        pri=dos.last
        pri.destroy        
        render "/productos/resultado_imp"#+$ord.idorden
        #redirect_to "http://127.0.0.1:8000/compra/orden/"#+$ord.idorden

  else
    @nn=0 # producto nuevo
    @a=0 #producto actualizado
    @o=0 #Detallo Orden creada
    @s=0  #Stock creado

    #  doc = Nokogiri::XML.parse($browser.html)
    #  $ordhym=doc.css('[class="infoBlock package pane "]')
    #  $ordlimp=$ordhym.css("ul:nth-child(3)")
    #  $imas=$ordhym.css("ul:nth-child(2) img[2]")
    #  # $pres=$ordhym.css("ul:nth-child(2) span[2] span[1]") preio unitario
    #  $pres=$ordhym.css('[class="priceTotal"] span') #precio total
    #ver de hacerle un Shift a $ordlimp para que no cree la 1° fila en el bucle que luego hay q borrarla
    $ord=Orden.new
    $ord.id_pedidos=Pedido.last.idpedidos
    $ord.orden=$ordhym.css('[id="delivery-0-deliveryDate"]').text# ver que ponems doc.css("h1").first.text[9,50]
    tofecha=Date.strptime($ordlimp.at_css("li[5] span[2]").text, "%m-%d-%Y")
    $ord.fecha=tofecha.to_formatted_s(:db)
    $ord.id_marca=2
    $ord.save
    #  u=0
    #  $liscods=0
    #  $liscods=[]
    #  $lista=0
    #  $lista=[]
    #  $lisq=0
    #  $lisq=[]
    #  $ordlimp.map do |li|
    #    $liscods[u]=li.css("li[4] span[2]").text
    #    $lista[u]=li.css("li[3] span[2]").text
    #    $lisq[u]=li.css("li[1] span[2]").text
    #    u=u+1
    #  end
    #  u=0
    #  $imal=0
    #  $imal=[]
    #  $imas.map do |li|
    #    $imal[u]=li.attr('src').gsub('small','large')
    #    u=u+1
    #  end
    #  u=0
    #  $prel=0
    #  $prel=[]
    #  $pres.map do |li|
    #    $prel[u]=li.text[1,10]
    #    u=u+1
    #  end
    #  $browser.goto("http://www.hm.com/us/quickorder")
    #  n=0
    #  $liscodl=0
    #  $liscodl=[]
    #  $liscodf=0
    #  $liscodf=[]
    #  $prod=0
    #  $prod=[]

    #  $liscods.map do |cs|
    #    $browser.text_field(:id => 'input-articleNumber-0').set(cs)
    #    sleep 1
    #    $browser.text_field(:id => 'input-articleNumber-1').set()
    #    sleep 2
    #    doc = Nokogiri::XML.parse($browser.html)
    #    sleep 1
    #    $liscodl[n]=doc.css('[class="imageItem"] button').attr('data-article').value
    #    $liscodf[n]=$liscodl[n]+$lista[n]
    #    $prod[n]=doc.css("h2")[1].text[0,80].strip
    #    sleep 2
    #    n=n+1
    #  end
      n=0
      $liscodf.map do |deto|
        @i_codebar_final=deto
        @i_imagen=$imal[n]
        @i_producto=$descrl[n]
        @i_talle=$lista[n]
         #@i_stock==row.css("td[2]").text.strip!
        @i_cant=$lisq[n]
        @i_precio=$prel[n]
        n=n+1

        @buscapro=Producto.where(codebar:  @i_codebar_final).first
        
        if @buscapro.blank? || @buscapro.codebar=="xxxxxx"
          # @buscapro es = vacio ->no existe codebar igual

          pro=Producto.new
          pro.imagen=@i_imagen
          pro.producto=@i_producto
          pro.talle=@i_talle
          pro.codebar=@i_codebar_final
          pro.id_marca=2
          pro.save
          @nn=@nn+1
          idpro=Producto.find(pro.idproducto)
          deta=Detalleorden.new
          deta.id_orden=$ord.idorden
          deta.id_tipo=@tipo
          deta.id_producto=idpro.idproducto
          deta.cant=@i_cant
          deta.precio=@i_precio
          #deta.id_tipo como predetrminado esta en 1
          deta.save
          
          @o=@o+1
          i=0
          while i < deta.cant do
          sto=Stock.new
          sto.id_detalleorden=deta.iddetalleorden
          sto.stock=1
          sto.estado="Comprado"
          sto.save
          i=i+1
          @s=@s+1
          end
        else
          @buscapro.imagen=@i_imagen # row.at_css("td div img").attr('src')
          @buscapro.producto=@i_producto #row.at_css("td div:nth-child(2) div").text

          @buscapro.talle=@i_talle #row.at_css("td div:nth-child(3)").text[5,20]
          @buscapro.codebar=@i_codebar_final #codebar_final
            #buscapro.stock + row.css("td[2]").text.strip!
          @buscapro.save
          @a=@a+1
          idpro=Producto.find(@buscapro.idproducto)
          deta=Detalleorden.new
          deta.id_orden=$ord.idorden
          deta.id_tipo=@tipo
          deta.id_producto=idpro.idproducto
          deta.cant=@i_cant
          deta.precio=@i_precio
          #deta.id_tipo como predetrminado esta en 1
          deta.save
          @o=@o+1
          i=0
          while i < deta.cant do
          sto=Stock.new
          sto.id_detalleorden=deta.iddetalleorden
          sto.stock=1
          sto.estado="Comprado"
          sto.save
          i=i+1
          @s=@s+1
          end
        end
      end
      @n=@nn
      dos=Detalleorden.where id_producto: 1 
      pri=dos.last
      pri.destroy
      render "/productos/resultado_imp"



  end
  end



  def remplazar_todo
    @buscapro.imagen=@i_imagen # row.at_css("td div img").attr('src')
    @buscapro.producto=@i_producto #row.at_css("td div:nth-child(2) div").text
    @buscapro.style=@i_style #row.at_css("td div:nth-child(2) span").text[6,30]
    @buscapro.talle=@i_talle #row.at_css("td div:nth-child(3)").text[5,20]
    @buscapro.codebar=@i_codebar_final #codebar_final
    @buscapro.stock = @buscapro.stock + @i_stock  #buscapro.stock + row.css("td[2]").text.strip!
    @buscapro.save
    @a=@a+1
    idpro=Producto.find(@buscapro.idproducto)
    deta=Detalleorden.new
    deta.id_orden=$ord.idorden
    deta.id_tipo=@tipo
    deta.id_producto=idpro.idproducto
    deta.cant=@i_cant
    deta.precio=@i_precio
    #deta.id_tipo como predetrminado esta en 1
    deta.save
    @o=@o+1
  end
  def remplazar_stock
    @buscapro.stock =  @buscapro.stock + @i_stock #row.css("td[2]").text.strip! #no Acepta, se agrega solo el stock
    @buscapro.save
    @a=@a+1
    idpro=Producto.find(@buscapro.idproducto)
    deta=Detalleorden.new
    deta.id_orden=$ord.idorden
    deta.id_tipo=@tipo
    deta.id_producto=idpro.idproducto
    deta.cant=@i_cant
    deta.precio=@i_precio
    #deta.id_tipo como predetrminado esta en 1
    deta.save
    @o=@o+1
  end


  # GET /productos
  # GET /productos.json
  def index
    @productos = Producto.all
  end

  # GET /productos/1
  # GET /productos/1.json
  def show
  end

  # GET /productos/new
  def new
    @producto = Producto.new
  end

  # GET /productos/1/edit
  def edit
  end

  # POST /productos
  # POST /productos.json
  def create
    @producto = Producto.new(producto_params)

    respond_to do |format|
      if @producto.save
        format.html { redirect_to @producto, notice: 'Producto was successfully created.' }
        format.json { render :show, status: :created, location: @producto }
      else
        format.html { render :new }
        format.json { render json: @producto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /productos/1
  # PATCH/PUT /productos/1.json
  def update
    respond_to do |format|
      if @producto.update(producto_params)
        format.html { redirect_to @producto, notice: 'Producto was successfully updated.' }
        format.json { render :show, status: :ok, location: @producto }
      else
        format.html { render :edit }
        format.json { render json: @producto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /productos/1
  # DELETE /productos/1.json
  def destroy
    @producto.destroy
    respond_to do |format|
      format.html { redirect_to productos_url, notice: 'Producto was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_producto
      @producto = Producto.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def producto_params
      params.require(:producto).permit(:codebar, :producto, :talle, :style, :imagen, :marca, :id_tipo, :id)
    end
end
