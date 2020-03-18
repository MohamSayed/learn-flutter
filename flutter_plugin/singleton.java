class singleton {
    private static final singleton ourInstance = new singleton();

    static singleton getInstance() {
        return ourInstance;
    }

    private singleton() {
    }
}
