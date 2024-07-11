package com.datn.food_delivery.controllers;

import com.datn.food_delivery.dto.ShopDTO;
import com.datn.food_delivery.models.Shop;
import com.datn.food_delivery.service.ShopService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.List;
import java.util.Random;
import java.util.concurrent.ExecutionException;

@Controller
@RequestMapping("/fooddelivery/shop")
public class ShopPageController {
    @Autowired
    private ShopService shopService;

    @GetMapping("")
    public String ShowShopList(Model model) throws ExecutionException, InterruptedException {
        List<Shop> shops = shopService.getAllShops();
        model.addAttribute("shops", shops);
        return "shop/index";
    }

    @GetMapping("/create")
    public String CreateShop(){
        return "shop/create";
    }

    @PostMapping("/store")
    public String SaveShop(ShopDTO shopDTO) throws IOException {
        final Long id = new Random().nextLong(1000000);
        shopDTO.setShop_id(id);
        String imageURl = null;
        if(!shopDTO.getImageURL().isEmpty()){
            imageURl = shopService.uploadFile(shopDTO.getImageURL());
        }
        Shop shop = new Shop(shopDTO.getShop_id(), shopDTO.getName(), shopDTO.getAddress(), imageURl);
        shopService.saveShop(shop);
        return "redirect:/fooddelivery/shop";
    }

    @GetMapping("/edit/{id}")
    public String EditShop(@PathVariable Long id, Model model) throws ExecutionException, InterruptedException {
        Shop shop = shopService.getShopById(id);
        ShopDTO shopDTO = new ShopDTO(shop.getShop_id(), shop.getName(), shop.getAddress());
        model.addAttribute("shopDTO", shopDTO);
        model.addAttribute("shop", shop);
        return "shop/edit";
    }

    @PostMapping("/edit/update")
    public String UpdateShop(ShopDTO shopDTO) throws ExecutionException, InterruptedException, IOException {
        Shop shop_old = shopService.getShopById(shopDTO.getShop_id());
        String imageURl = shop_old.getImageURL();
        String newImageURl = shopService.uploadFile(shopDTO.getImageURL());
        if(newImageURl!=null){
            imageURl = newImageURl;
        }
        Shop shop = new Shop(shopDTO.getShop_id(), shopDTO.getName(), shopDTO.getAddress(), imageURl);
        shopService.saveShop(shop);
        return "redirect:/fooddelivery/shop";
    }

    @GetMapping("/destroy/{id}")
    public String DestroyShop(@PathVariable Long id) throws ExecutionException, InterruptedException {
        shopService.deleteShop(id);
        return "redirect:/fooddelivery/shop";
    }
}
