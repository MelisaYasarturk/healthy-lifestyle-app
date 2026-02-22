-- CreateTable
CREATE TABLE "auth_users" (
    "id" UUID NOT NULL,

    CONSTRAINT "auth_users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "profiles" (
    "id" UUID NOT NULL,
    "full_name" TEXT,
    "gender" TEXT,
    "birth_date" DATE,
    "height_cm" DECIMAL,
    "weight_kg" DECIMAL,
    "goal_type" TEXT,
    "activity_level" TEXT,
    "target_weight_kg" DECIMAL,

    CONSTRAINT "profiles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user_settings" (
    "id" BIGSERIAL NOT NULL,
    "user_id" UUID NOT NULL,
    "timezone" TEXT,
    "daily_calorie_target" INTEGER,
    "water_target_ml" INTEGER,
    "notifications_enabled" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "user_settings_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "allergens" (
    "id" BIGSERIAL NOT NULL,
    "code" TEXT,
    "name" TEXT,

    CONSTRAINT "allergens_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user_allergies" (
    "id" BIGSERIAL NOT NULL,
    "user_id" UUID NOT NULL,
    "allergen_id" BIGINT NOT NULL,

    CONSTRAINT "user_allergies_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "foods" (
    "id" BIGSERIAL NOT NULL,
    "name" TEXT,
    "source" TEXT,
    "serving_size_g" DECIMAL,
    "calories_kcal" DECIMAL,
    "protein_g" DECIMAL,
    "carbs_g" DECIMAL,
    "fat_g" DECIMAL,
    "fiber_g" DECIMAL,
    "sugar_g" DECIMAL,
    "sodium_mg" DECIMAL,

    CONSTRAINT "foods_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "meals" (
    "id" BIGSERIAL NOT NULL,
    "user_id" UUID NOT NULL,
    "meal_type" TEXT,
    "meal_time" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "meals_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "meal_items" (
    "id" BIGSERIAL NOT NULL,
    "meal_id" BIGINT NOT NULL,
    "food_id" BIGINT NOT NULL,
    "quantity" DECIMAL,
    "amount_g" DECIMAL,
    "calories_kcal" DECIMAL,

    CONSTRAINT "meal_items_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "recipes" (
    "id" BIGSERIAL NOT NULL,
    "user_id" UUID NOT NULL,
    "name" TEXT,

    CONSTRAINT "recipes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "recipe_ingredients" (
    "id" BIGSERIAL NOT NULL,
    "recipe_id" BIGINT NOT NULL,
    "food_id" BIGINT NOT NULL,
    "quantity" DECIMAL,

    CONSTRAINT "recipe_ingredients_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "exercises" (
    "id" BIGSERIAL NOT NULL,
    "name" TEXT,
    "category" TEXT,
    "muscle_group" TEXT,
    "met_value" DECIMAL,

    CONSTRAINT "exercises_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "exercise_logs" (
    "id" BIGSERIAL NOT NULL,
    "user_id" UUID NOT NULL,
    "exercise_id" BIGINT NOT NULL,
    "start_time" TIMESTAMPTZ(6) NOT NULL,
    "end_time" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "exercise_logs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "products" (
    "id" BIGSERIAL NOT NULL,
    "barcode" TEXT,
    "name" TEXT,
    "brand" TEXT,

    CONSTRAINT "products_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "product_nutrients" (
    "id" BIGSERIAL NOT NULL,
    "product_id" BIGINT NOT NULL,
    "per" TEXT,
    "calories_kcal" DECIMAL,
    "protein_g" DECIMAL,
    "carbs_g" DECIMAL,
    "fat_g" DECIMAL,
    "sugar_g" DECIMAL,
    "sodium_mg" DECIMAL,

    CONSTRAINT "product_nutrients_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "product_ingredients" (
    "id" BIGSERIAL NOT NULL,
    "product_id" BIGINT NOT NULL,
    "ingredient_text" TEXT,
    "allergen_id" BIGINT,

    CONSTRAINT "product_ingredients_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "achievements" (
    "id" BIGSERIAL NOT NULL,
    "code" TEXT,
    "name" TEXT,

    CONSTRAINT "achievements_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user_achievements" (
    "id" BIGSERIAL NOT NULL,
    "user_id" UUID NOT NULL,
    "achievement_id" BIGINT NOT NULL,

    CONSTRAINT "user_achievements_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "daily_summaries" (
    "id" BIGSERIAL NOT NULL,
    "user_id" UUID NOT NULL,
    "date" DATE NOT NULL,
    "total_calories" DECIMAL,

    CONSTRAINT "daily_summaries_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "user_settings_user_id_idx" ON "user_settings"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "allergens_code_key" ON "allergens"("code");

-- CreateIndex
CREATE INDEX "user_allergies_user_id_idx" ON "user_allergies"("user_id");

-- CreateIndex
CREATE INDEX "user_allergies_allergen_id_idx" ON "user_allergies"("allergen_id");

-- CreateIndex
CREATE UNIQUE INDEX "user_allergies_user_id_allergen_id_key" ON "user_allergies"("user_id", "allergen_id");

-- CreateIndex
CREATE INDEX "meals_user_id_idx" ON "meals"("user_id");

-- CreateIndex
CREATE INDEX "meal_items_meal_id_idx" ON "meal_items"("meal_id");

-- CreateIndex
CREATE INDEX "meal_items_food_id_idx" ON "meal_items"("food_id");

-- CreateIndex
CREATE INDEX "recipes_user_id_idx" ON "recipes"("user_id");

-- CreateIndex
CREATE INDEX "recipe_ingredients_recipe_id_idx" ON "recipe_ingredients"("recipe_id");

-- CreateIndex
CREATE INDEX "recipe_ingredients_food_id_idx" ON "recipe_ingredients"("food_id");

-- CreateIndex
CREATE UNIQUE INDEX "recipe_ingredients_recipe_id_food_id_key" ON "recipe_ingredients"("recipe_id", "food_id");

-- CreateIndex
CREATE INDEX "exercise_logs_user_id_idx" ON "exercise_logs"("user_id");

-- CreateIndex
CREATE INDEX "exercise_logs_exercise_id_idx" ON "exercise_logs"("exercise_id");

-- CreateIndex
CREATE UNIQUE INDEX "products_barcode_key" ON "products"("barcode");

-- CreateIndex
CREATE INDEX "product_nutrients_product_id_idx" ON "product_nutrients"("product_id");

-- CreateIndex
CREATE INDEX "product_ingredients_product_id_idx" ON "product_ingredients"("product_id");

-- CreateIndex
CREATE INDEX "product_ingredients_allergen_id_idx" ON "product_ingredients"("allergen_id");

-- CreateIndex
CREATE UNIQUE INDEX "achievements_code_key" ON "achievements"("code");

-- CreateIndex
CREATE INDEX "user_achievements_user_id_idx" ON "user_achievements"("user_id");

-- CreateIndex
CREATE INDEX "user_achievements_achievement_id_idx" ON "user_achievements"("achievement_id");

-- CreateIndex
CREATE UNIQUE INDEX "user_achievements_user_id_achievement_id_key" ON "user_achievements"("user_id", "achievement_id");

-- CreateIndex
CREATE INDEX "daily_summaries_user_id_idx" ON "daily_summaries"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "daily_summaries_user_id_date_key" ON "daily_summaries"("user_id", "date");

-- AddForeignKey
ALTER TABLE "profiles" ADD CONSTRAINT "profiles_id_fkey" FOREIGN KEY ("id") REFERENCES "auth_users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_settings" ADD CONSTRAINT "user_settings_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "profiles"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_allergies" ADD CONSTRAINT "user_allergies_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "profiles"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_allergies" ADD CONSTRAINT "user_allergies_allergen_id_fkey" FOREIGN KEY ("allergen_id") REFERENCES "allergens"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "meals" ADD CONSTRAINT "meals_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "profiles"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "meal_items" ADD CONSTRAINT "meal_items_meal_id_fkey" FOREIGN KEY ("meal_id") REFERENCES "meals"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "meal_items" ADD CONSTRAINT "meal_items_food_id_fkey" FOREIGN KEY ("food_id") REFERENCES "foods"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "recipes" ADD CONSTRAINT "recipes_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "profiles"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "recipe_ingredients" ADD CONSTRAINT "recipe_ingredients_recipe_id_fkey" FOREIGN KEY ("recipe_id") REFERENCES "recipes"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "recipe_ingredients" ADD CONSTRAINT "recipe_ingredients_food_id_fkey" FOREIGN KEY ("food_id") REFERENCES "foods"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "exercise_logs" ADD CONSTRAINT "exercise_logs_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "profiles"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "exercise_logs" ADD CONSTRAINT "exercise_logs_exercise_id_fkey" FOREIGN KEY ("exercise_id") REFERENCES "exercises"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "product_nutrients" ADD CONSTRAINT "product_nutrients_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "products"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "product_ingredients" ADD CONSTRAINT "product_ingredients_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "products"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "product_ingredients" ADD CONSTRAINT "product_ingredients_allergen_id_fkey" FOREIGN KEY ("allergen_id") REFERENCES "allergens"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_achievements" ADD CONSTRAINT "user_achievements_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "profiles"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_achievements" ADD CONSTRAINT "user_achievements_achievement_id_fkey" FOREIGN KEY ("achievement_id") REFERENCES "achievements"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "daily_summaries" ADD CONSTRAINT "daily_summaries_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "profiles"("id") ON DELETE CASCADE ON UPDATE CASCADE;
