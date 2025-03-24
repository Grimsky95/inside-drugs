function Notify(text, type, duration) {
    $.post('https://inside-selldrugs/notification', JSON.stringify({ text: text, type: type, duration: duration }));
}