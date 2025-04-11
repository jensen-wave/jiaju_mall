package com.hspedu.furns.entity;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Set;

public class Cart {

    // 定義屬性，使用 HashMap 保存購物車中的商品項
    private HashMap<Integer, CartItem> items = new HashMap<>();

    // 獲取購物車中的所有商品項
    public HashMap<Integer, CartItem> getItems() {
        return items;
    }

    // 判斷購物車是否為空
    public boolean isEmpty() {
        return items.size() == 0; // 如果 items 的大小為 0，表示購物車為空
    }

    // 清空購物車中的所有商品項
    public void clear() {
        items.clear(); // 調用 HashMap 的 clear() 方法清空鍵值對
    }

    /**
     * 根據傳入的 id，刪除指定的購物車項
     *
     * @param id 商品的唯一標識
     */
    public void delItem(int id) {
        items.remove(id); // 調用 HashMap 的 remove() 方法刪除指定 id 的商品項
    }

    /**
     * 修改指定的 CartItem 的數量和總價，根據傳入的 id 和 count
     *
     * @param id    商品的唯一標識
     * @param count 更新後的商品數量
     */
    public void updateCount(int id, int count) {

        // 根據 id 從購物車的 items 中獲取對應的 CartItem 對象
        CartItem item = items.get(id);

        // 判斷是否獲取到了有效的 CartItem 物件
        if (null != item) { // 如果找到對應的商品項
            // 更新該 CartItem 的數量為傳入的 count
            item.setCount(count);

            // 根據新的數量更新 CartItem 的總價
            // 計算公式為 單價(price) * 數量(count)
            item.setTotalPrice(item.getPrice().multiply(new BigDecimal(item.getCount())));
        }

        // 如果 item 為 null，不做任何處理
    }

    /**
     * 返回購物車的總價
     *
     * @return 購物車中所有商品的總價
     */
    public BigDecimal getCartTotalPrice() {
        BigDecimal cartTotalPrice = new BigDecimal(0); // 初始化總價為 0

        // 遍歷購物車中的所有商品項，計算總價
        Set<Integer> keys = items.keySet(); // 獲取所有商品項的 id
        for (Integer id : keys) {
            CartItem item = items.get(id); // 根據 id 獲取商品項
            // 將每個商品項的總價累加到 cartTotalPrice
            cartTotalPrice = cartTotalPrice.add(item.getTotalPrice());
        }

        return cartTotalPrice; // 返回計算出的總價
    }

    // 獲取購物車中商品的總數量
    public Integer getTotalCount() {
        int totalCount = 0; // 初始化總數量為 0

        // 遍歷購物車中的所有商品項，計算總數量
        Set<Integer> keys = items.keySet(); // 獲取所有商品項的 id
        for (Integer id : keys) {
            CartItem item = items.get(id); // 根據 id 獲取商品項
            totalCount += item.getCount(); // 累加商品數量
        }

        return totalCount; // 返回總數量
    }

    // 添加商品項 [CartItem] 到購物車
    public void addItem(CartItem cartItem) {

        // 根據商品 id 檢查購物車中是否已有該商品項
        CartItem item = items.get(cartItem.getId());

        if (null == item) { // 如果購物車中沒有該商品項
            items.put(cartItem.getId(), cartItem); // 添加該商品項到購物車
        } else { // 如果購物車中已有該商品項
            item.setCount(item.getCount() + 1); // 數量增加 1
            // 更新總價：當前總價 + 商品單價
            item.setTotalPrice(item.getTotalPrice().add(item.getPrice()));
        }
    }

    @Override
    public String toString() {
        // 重寫 toString 方法，便於調試時列印購物車的內容
        return "Cart{" +
                "items=" + items +
                '}';
    }
}

