package com.restaurant.model;

public class FoodItem {

    private int foodId;
    private int categoryId;
    private String foodName;
    private String description;
    private double price;
    private String imagePath;
    private int availability;
    private String createdAt;
    private String categoryName;

    public FoodItem() {
    }

    public FoodItem(int foodId, int categoryId, String foodName,
            String description, double price, String imagePath,
            int availability, String createdAt) {

        this.foodId = foodId;
        this.categoryId = categoryId;
        this.foodName = foodName;
        this.description = description;
        this.price = price;
        this.imagePath = imagePath;
        this.availability = availability;
        this.createdAt = createdAt;
    }

    public int getFoodId() {
        return foodId;
    }

    public void setFoodId(int foodId) {
        this.foodId = foodId;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getFoodName() {
        return foodName;
    }

    public void setFoodName(String foodName) {
        this.foodName = foodName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    public int getAvailability() {
        return availability;
    }

    public void setAvailability(int availability) {
        this.availability = availability;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }
    public String getCategoryName() {
    return categoryName;
}

public void setCategoryName(String categoryName) {
    this.categoryName = categoryName;
}
}