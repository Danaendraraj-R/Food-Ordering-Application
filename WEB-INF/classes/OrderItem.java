import java.util.Objects;

public class OrderItem {
    private int restid;
    private int dishId;
    private String dishname;
    private int cost;

    public OrderItem() {
        
    }

    public OrderItem(int restid, int dishId, String dishname, int cost) {
        this.restid = restid;
        this.dishId = dishId;
        this.dishname = dishname;
        this.cost = cost;
    }

    public int getRestid() {
        return restid;
    }

    public void setRestid(int restid) {
        this.restid = restid;
    }

    public int getDishid() {
        return dishId;
    }

    public void setDishid(int dishId) {
        this.dishId = dishId;
    }

    public String getDishname() {
        return dishname;
    }

    public void setDishname(String dishname) {
        this.dishname = dishname;
    }

    public int getCost() {
        return cost;
    }

    public void setCost(int cost) {
        this.cost = cost;
    }



    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        OrderItem orderItem = (OrderItem) o;
        return Double.compare(orderItem.cost, cost) == 0 &&
                Objects.equals(restid, orderItem.restid) &&
                Objects.equals(dishId, orderItem.dishId) &&
                Objects.equals(dishname, orderItem.dishname);
    }

    @Override
    public int hashCode() {
        return Objects.hash(restid, dishId, dishname, cost);
    }

    @Override
    public String toString() {
        return "OrderItem{" +
                "restid='" + restid + '\'' +
                ", dishid='" + dishId + '\'' +
                ", dishname='" + dishname + '\'' +
                ", cost=" + cost + '\'' +
                '}';
    }
}
