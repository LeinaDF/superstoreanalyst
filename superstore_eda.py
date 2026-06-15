import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

df = pd.read_csv('superstore.csv')

# 1. Базовый просмотр
print(df.shape)
print(df.isnull().sum())

# 2. Продажи по регионам
sales_by_region = df.groupby('Region')['Sales'].sum().sort_values(ascending=False)
print(sales_by_region)

# 3. Продажи по категориям
sales_by_category = df.groupby('Category')['Sales'].sum().sort_values(ascending=False)
print(sales_by_category)

# 4. Топ-5 городов
top_cities = df.groupby('City')['Sales'].sum().sort_values(ascending=False).head(5)
print(top_cities)

# 5. Графики
fig, axes = plt.subplots(2, 2, figsize=(12, 10))

sns.barplot(data=sales_by_region.reset_index(), x='Region', y='Sales', ax=axes[0,0])
axes[0,0].set_title('Продажи по регионам')

sns.barplot(data=sales_by_category.reset_index(), x='Category', y='Sales', ax=axes[0,1])
axes[0,1].set_title('Продажи по категориям')

sns.boxplot(data=df, x='Category', y='Sales', ax=axes[1,0])
axes[1,0].set_title('Распределение продаж')

sns.countplot(data=df, x='Region', ax=axes[1,1])
axes[1,1].set_title('Количество заказов по регионам')

plt.tight_layout()
plt.savefig('superstore_analysis.png')
plt.show()