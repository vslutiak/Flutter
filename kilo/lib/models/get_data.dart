class GetData {
  static day(int day) {
    switch (day) {
      case 1:
        return 'пн';
      case 2:
        return 'вт';
      case 3:
        return 'ср';
      case 4:
        return 'чт';
      case 5:
        return 'пт';
      case 6:
        return 'сб';
      case 7:
        return 'вс';
    }
  }

  static month(int month) {
    switch (month) {
      case 1:
        return 'Январь';
      case 2:
        return 'Февраль';
      case 3:
        return 'Март';
      case 4:
        return 'Апрель';
      case 5:
        return 'Май';
      case 6:
        return 'Июнь';
      case 7:
        return 'Июль';
      case 8:
        return 'Август';
      case 9:
        return 'Сентябрь';
      case 10:
        return 'Октябрь';
      case 11:
        return 'Ноябрь';
      case 12:
        return 'Декабрь';
    }
  }
}
